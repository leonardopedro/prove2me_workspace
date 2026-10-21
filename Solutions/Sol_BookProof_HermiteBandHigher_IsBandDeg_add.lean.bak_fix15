-- Generated from ChapterHermiteBandCalculusHigher.lean — solution of BookProof.HermiteBandHigher.IsBandDeg.add
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculusHigher
import Theorems.Thm_BookProof_HermiteBandHigher_Band_monoR
import Theorems.Thm_BookProof_HermiteBandHigher_IsBandR_monoR
import Theorems.Thm_BookProof_HermiteBandHigher_IsBandR_add
open BookProof.HermiteBandHigher




noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.YangMillsHermite
open BookProof.NavierStokesFlow.DifferentialL2

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {m : ℕ} {T S : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ}
    (hT : IsBandDeg m T) (hS : IsBandDeg m S) : IsBandDeg m (T + S) := by

  obtain ⟨r₁, h₁⟩ := hT
  obtain ⟨r₂, h₂⟩ := hS
  exact ⟨max r₁ r₂, (h₁.monoR (le_max_left _ _)).add (h₂.monoR (le_max_right _ _))⟩
