-- Generated from ChapterHermiteBandCalculusHigher.lean — solution of BookProof.HermiteBandHigher.IsBandR.le
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculusHigher
import Theorems.Thm_BookProof_HermiteBandHigher_gpow_mono
import Theorems.Thm_BookProof_HermiteBandHigher_Band_monoG
open BookProof.HermiteBandHigher




noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.YangMillsHermite
open BookProof.NavierStokesFlow.DifferentialL2

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {r m m' : ℕ} {T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ}
    (hm : m ≤ m') (h : IsBandR r m T) : IsBandR r m' T := by

  obtain ⟨M, C, hC, hB⟩ := h
  exact ⟨M, C, hC, Band.monoG hC (fun n => gpow_mono hm n) hB⟩
