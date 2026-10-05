-- Generated from ChapterNsFieldMomentumInverse.lean — solution of BookProof.NsFieldMomentumInverse.isMomInverse_momentumOp
import Mathlib
import Definitions.Def_ChapterNsFieldMomentumInverse
open BookProof.NsFieldMomentumInverse




open MeasureTheory SchwartzMap FourierTransform
open BookProof.NsSpatialMultiplier BookProof.FourierMultiplierEsa BookProof.StrichartzWave

noncomputable section

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [FiniteDimensional ℝ W]
  [MeasurableSpace W] [BorelSpace W]

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [FiniteDimensional ℝ W]
  [MeasurableSpace W] [BorelSpace W]

set_option maxHeartbeats 1000000 in
theorem solution (m : W) (f : 𝓢(W, ℂ)) :
    IsMomInverse m (l2Fourier W (opL2 (momentumOp m) (schwartzEquiv W f)))
      (l2Fourier W (f.toLp 2 (volume : Measure W))) := by

  have hrep := fourier_opL2_momentumOp m f
  have hl : (l2Fourier W (f.toLp 2 (volume : Measure W)) : W → ℂ)
      =ᵐ[(volume : Measure W)] fun ξ => (𝓕 f : 𝓢(W, ℂ)) ξ := by
    rw [l2Fourier_apply, SchwartzMap.toLp_fourier_eq]
    exact (𝓕 f : 𝓢(W, ℂ)).coeFn_toLp 2 (volume : Measure W)
  have hr : (l2Fourier W (opL2 (momentumOp m) (schwartzEquiv W f)) : W → ℂ)
      =ᵐ[(volume : Measure W)]
        fun ξ => ((momSymbol m ξ : ℝ) : ℂ) * (𝓕 f : 𝓢(W, ℂ)) ξ := by
    rw [hrep]
    filter_upwards [(mulSymbolOp (fun x => 2 * Real.pi * (inner ℝ x m : ℝ))
      (𝓕 f : 𝓢(W, ℂ))).coeFn_toLp 2 (volume : Measure W)] with ξ hξ
    rw [hξ]
    have hσ : Function.HasTemperateGrowth
        (fun x : W => ((2 * Real.pi * (inner ℝ x m : ℝ) : ℝ) : ℂ)) := by
      have h := hasTemperateGrowth_foSymbol (fun _ : Fin 1 => (1 : ℝ)) (fun _ => m)
      simpa [foSymbolFn] using h
    rw [mulSymbolOp_apply _ hσ]
    rfl
  filter_upwards [hl, hr] with ξ hxl hxr
  rw [hxl, hxr]
