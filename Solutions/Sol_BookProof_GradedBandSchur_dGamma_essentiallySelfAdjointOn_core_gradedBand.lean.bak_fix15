-- Generated from ChapterGradedBandSchurEsa.lean — solution of BookProof.GradedBandSchur.dGamma_essentiallySelfAdjointOn_core_gradedBand
import Mathlib
import Definitions.Def_ChapterGradedBandSchurEsa
import Theorems.Thm_BookProof_GradedBandSchur_degW_ge_one
import Theorems.Thm_BookProof_GradedBandSchur_wRow_of_gradedBand
import Theorems.Thm_BookProof_GradedBandSchur_wCol_of_gradedBand
import Theorems.Thm_BookProof_GradedBandSchur_wComm_of_gradedBand
import Theorems.Thm_BookProof_FockWeightedSchur_dGamma_essentiallySelfAdjointOn_core_w
open BookProof.GradedBandSchur




open BookProof.FockSecondQuantization BookProof.FockSchur BookProof.FockWeightedSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow

noncomputable section

variable {col : ℕ → (ℕ →₀ ℂ)} {deg : ℕ → ℕ} {D M : ℕ} {C : ℝ}

variable {col : ℕ → (ℕ →₀ ℂ)} {deg : ℕ → ℕ} {D M : ℕ} {C : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hC : 0 ≤ C) (hherm : IsHermCol col)
    (hcard : ∀ k, (col k).support.card ≤ M)
    (hband : ∀ k, ∀ j ∈ (col k).support, ((deg j : ℤ) - (deg k : ℤ)).natAbs ≤ D)
    (hent : ∀ k j, ‖(col k) j‖ ≤ C * ((deg k : ℝ) + 1)) :
    EssentiallySelfAdjointOn (lpFiniteModes Conf) (dGammaOp col) :=
  dGamma_essentiallySelfAdjointOn_core_w (degW_ge_one deg) hherm
      (wRow_of_gradedBand hC hcard hent) (wCol_of_gradedBand hC hherm hcard hent)
      (mul_nonneg hC (by positivity)) (wComm_of_gradedBand hC hcard hband hent)
