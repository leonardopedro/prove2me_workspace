-- Generated from ChapterRitzCertificate.lean — solution of BookProof.RitzCertificate.temple_width_tendsto_zero
import Mathlib
import Definitions.Def_ChapterRitzCertificate
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterBandEnclosure
open BookProof.RitzCertificate














noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterSirkRitzSpectrum BookProof.BandEnclosure


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]














variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution {A : F →L[ℂ] F} {b delta : ℝ} {x : ℕ → F}
    (hdelta : 0 < delta) (hle : ∀ m, rayleigh A (x m) ≤ b - delta)
    (hres : Tendsto (fun m => resid A (x m)) atTop (𝓝 0)) :
    Tendsto (fun m => rayleigh A (x m) -
      (rayleigh A (x m) - resid A (x m) ^ 2 / (b - rayleigh A (x m)))) atTop (𝓝 0) := by

  have hsq : Tendsto (fun m => resid A (x m) ^ 2) atTop (𝓝 0) := by
    simpa using hres.pow 2
  have hsqueeze : ∀ m, |rayleigh A (x m) -
      (rayleigh A (x m) - resid A (x m) ^ 2 / (b - rayleigh A (x m)))|
        ≤ resid A (x m) ^ 2 / delta := by
    intro m
    have hb : delta ≤ b - rayleigh A (x m) := by linarith [hle m]
    have hnn : 0 ≤ resid A (x m) ^ 2 := sq_nonneg _
    have : resid A (x m) ^ 2 / (b - rayleigh A (x m)) ≤ resid A (x m) ^ 2 / delta :=
      div_le_div_of_nonneg_left hnn hdelta hb
    have hpos : 0 ≤ resid A (x m) ^ 2 / (b - rayleigh A (x m)) :=
      div_nonneg hnn (by linarith)
    rw [abs_of_nonneg (by linarith)]
    linarith
  have hbound : Tendsto (fun m => resid A (x m) ^ 2 / delta) atTop (𝓝 0) := by
    simpa using hsq.div_const delta
  exact squeeze_zero_norm hsqueeze hbound
