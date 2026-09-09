-- Generated from ChapterRitzCertificate.lean — solution of BookProof.RitzCertificate.temple_nested_certificate
import Mathlib
import Definitions.Def_ChapterRitzCertificate
import Theorems.Thm_BookProof_RitzCertificate_temple_band_mem
import Theorems.Thm_BookProof_RitzCertificate_temple_width_tendsto_zero
import Theorems.Thm_BookProof_RitzCertificate_nested_certificate_of_bands
open BookProof.RitzCertificate














noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterSirkRitzSpectrum BookProof.BandEnclosure


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]














variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]





















variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution [Nontrivial F] {A : F →L[ℂ] F} (hA : IsSelfAdjoint A)
    {b delta : ℝ} {x : ℕ → F} (hsep : SpectralSeparation A (sInf (spectrum ℝ A)) b)
    (hdelta : 0 < delta) (hx : ∀ m, ‖x m‖ = 1) (hle : ∀ m, rayleigh A (x m) ≤ b - delta)
    (hres : Tendsto (fun m => resid A (x m)) atTop (𝓝 0)) :
    NestedBands (runLo fun m => rayleigh A (x m) - resid A (x m) ^ 2 / (b - rayleigh A (x m)))
        (runHi fun m => rayleigh A (x m)) ∧
      (∀ m, sInf (spectrum ℝ A) ∈
        Set.Icc (runLo (fun m => rayleigh A (x m) -
            resid A (x m) ^ 2 / (b - rayleigh A (x m))) m)
          (runHi (fun m => rayleigh A (x m)) m)) ∧
      Tendsto (fun m => runHi (fun m => rayleigh A (x m)) m -
        runLo (fun m => rayleigh A (x m) -
          resid A (x m) ^ 2 / (b - rayleigh A (x m))) m) atTop (𝓝 0) := by

  have hlt : ∀ m, rayleigh A (x m) < b := fun m => by linarith [hle m]
  have hmem : ∀ m, sInf (spectrum ℝ A) ∈
      Set.Icc (rayleigh A (x m) - resid A (x m) ^ 2 / (b - rayleigh A (x m)))
        (rayleigh A (x m)) := fun m => temple_band_mem hA hsep (hx m) (hlt m)
  exact nested_certificate_of_bands hmem
    (temple_width_tendsto_zero hdelta hle hres)
