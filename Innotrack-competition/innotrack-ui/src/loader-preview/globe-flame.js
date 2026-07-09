import createGlobe from 'cobe'
import './globe-flame.css'

const flameMarkers = [
  { id: 'beijing', location: [39.9, 116.4], label: '被看见', note: '机会入口' },
  { id: 'shanghai', location: [31.23, 121.47], label: '被托举', note: '兜底指导' },
  { id: 'wuhan', location: [30.59, 114.3], label: '练手', note: '承担任务' },
  { id: 'xian', location: [34.34, 108.94], label: '能成事', note: '完整项目' },
  { id: 'chengdu', location: [30.67, 104.06], label: '愿带人', note: '让出机会' },
  { id: 'guangzhou', location: [23.13, 113.26], label: '再传承', note: '点亮下一届' },
  { id: 'nanjing', location: [32.06, 118.8], label: '文科问为什么', note: '价值判断' },
  { id: 'hangzhou', location: [30.25, 120.16], label: '技术答怎么做', note: '实现路径' },
]

const flameArcs = [
  { from: [39.9, 116.4], to: [31.23, 121.47], id: 'see-lift' },
  { from: [31.23, 121.47], to: [30.59, 114.3], id: 'lift-practice' },
  { from: [30.59, 114.3], to: [34.34, 108.94], id: 'practice-done' },
  { from: [34.34, 108.94], to: [30.67, 104.06], id: 'done-guide' },
  { from: [30.67, 104.06], to: [23.13, 113.26], id: 'guide-pass' },
  { from: [32.06, 118.8], to: [30.25, 120.16], id: 'human-tech' },
]

const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches

function hasWebGL() {
  const canvas = document.createElement('canvas')
  return Boolean(canvas.getContext('webgl') || canvas.getContext('experimental-webgl'))
}

function createFlameSticker(marker, index) {
  const sticker = document.createElement('div')
  sticker.className = 'flame-sticker'
  sticker.dataset.markerId = marker.id
  sticker.style.setProperty('position-anchor', `--cobe-${marker.id}`)
  sticker.style.setProperty('--cobe-visible', `var(--cobe-visible-${marker.id}, 0)`)
  sticker.style.setProperty('--tilt', `${[-7, 5, -3, 8, -5, 4, -8, 6][index % 8]}deg`)

  sticker.innerHTML = `
    <span class="flame-icon" aria-hidden="true"></span>
    <span class="flame-label">${marker.label}</span>
    <span class="flame-note">${marker.note}</span>
  `

  return sticker
}

function showFallback(reason) {
  document.documentElement.classList.add('is-globe-fallback')
  const fallback = document.querySelector('[data-globe-fallback]')
  if (fallback) {
    fallback.hidden = false
    fallback.querySelector('span').textContent = reason
  }
}

function initGlobeLoader() {
  const canvas = document.querySelector('[data-globe-canvas]')
  const wrap = document.querySelector('[data-globe-wrap]')
  const stickerLayer = document.querySelector('[data-flame-stickers]')

  if (!canvas || !wrap || !stickerLayer) return

  if (!hasWebGL()) {
    showFallback('当前环境暂不支持 WebGL，已切换为静态预览。')
    return
  }

  const supportsAnchor = CSS.supports?.('position-anchor: --cobe-test') && CSS.supports?.('bottom: anchor(top)')
  if (!supportsAnchor) {
    document.documentElement.classList.add('no-anchor-positioning')
  }

  flameMarkers.forEach((marker, index) => {
    stickerLayer.appendChild(createFlameSticker(marker, index))
  })

  let globe = null
  let animationId = 0
  let phi = -0.68
  let pointer = null
  let drag = { phi: 0, theta: 0 }
  let base = { phi: 0, theta: 0 }
  let paused = false

  const handlePointerDown = (event) => {
    pointer = { x: event.clientX, y: event.clientY }
    drag = { phi: 0, theta: 0 }
    paused = true
    canvas.setPointerCapture?.(event.pointerId)
    canvas.classList.add('is-dragging')
  }

  const handlePointerMove = (event) => {
    if (!pointer) return
    drag = {
      phi: (event.clientX - pointer.x) / 290,
      theta: Math.max(-0.65, Math.min(0.65, (event.clientY - pointer.y) / 520)),
    }
  }

  const handlePointerUp = (event) => {
    if (pointer) {
      base.phi += drag.phi
      base.theta = Math.max(-0.55, Math.min(0.55, base.theta + drag.theta))
    }
    pointer = null
    drag = { phi: 0, theta: 0 }
    paused = false
    canvas.releasePointerCapture?.(event.pointerId)
    canvas.classList.remove('is-dragging')
  }

  function resizeCanvas() {
    const width = Math.max(320, Math.floor(wrap.getBoundingClientRect().width))
    const pixelRatio = Math.min(window.devicePixelRatio || 1, 2)
    canvas.width = Math.floor(width * pixelRatio)
    canvas.height = Math.floor(width * pixelRatio)
    canvas.style.width = `${width}px`
    canvas.style.height = `${width}px`
    return { width: canvas.width, height: canvas.height, pixelRatio }
  }

  function destroyGlobe() {
    if (animationId) cancelAnimationFrame(animationId)
    if (globe) globe.destroy()
    globe = null
    animationId = 0
  }

  function create() {
    destroyGlobe()

    const { width, height, pixelRatio } = resizeCanvas()

    globe = createGlobe(canvas, {
      devicePixelRatio: pixelRatio,
      width,
      height,
      phi,
      theta: 0.16,
      dark: 0,
      diffuse: 1.45,
      scale: 1,
      mapSamples: 17000,
      mapBrightness: 7,
      baseColor: [0.98, 0.99, 1],
      markerColor: [1, 0.58, 0.16],
      glowColor: [0.87, 0.93, 1],
      opacity: 0.82,
      markerElevation: 0.025,
      markers: flameMarkers.map((marker, index) => ({
        id: marker.id,
        location: marker.location,
        size: index < 6 ? 0.036 : 0.028,
        color: index < 6 ? [1, 0.58, 0.16] : [0.2, 0.48, 1],
      })),
      arcs: flameArcs.map((arc, index) => ({
        ...arc,
        color: index === flameArcs.length - 1 ? [0.24, 0.55, 1] : [1, 0.62, 0.2],
      })),
      arcColor: [1, 0.62, 0.2],
      arcWidth: 0.65,
      arcHeight: 0.24,
      onRender: (state) => {
        if (!paused && !prefersReducedMotion) phi += 0.0032
        state.phi = phi + base.phi + drag.phi
        state.theta = 0.16 + base.theta + drag.theta
      },
    })

    canvas.classList.add('is-ready')
  }

  const resizeObserver = new ResizeObserver(() => {
    if (!globe) {
      create()
      return
    }
    create()
  })

  canvas.addEventListener('pointerdown', handlePointerDown)
  canvas.addEventListener('pointermove', handlePointerMove, { passive: true })
  canvas.addEventListener('pointerup', handlePointerUp)
  canvas.addEventListener('pointercancel', handlePointerUp)

  resizeObserver.observe(wrap)
  create()

  window.addEventListener('beforeunload', () => {
    resizeObserver.disconnect()
    destroyGlobe()
  })
}

initGlobeLoader()
