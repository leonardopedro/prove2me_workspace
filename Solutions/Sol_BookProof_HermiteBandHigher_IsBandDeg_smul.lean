-- Generated from ChapterHermiteBandCalculusHigher.lean — solution of BookProof.HermiteBandHigher.IsBandDeg.smul
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculusHigher
import Theorems.Thm_BookProof_HermiteBandHigher_IsBandR_smul
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterNavierStokesDifferentialL2
open BookProof.HermiteBandHigher




noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.YangMillsHermite
open BookProof.NavierStokesFlow.DifferentialL2

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {m : ℕ} {T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ}
    (c : ℂ) (hT : IsBandDeg m T) : IsBandDeg m (c • T) := by

  obtain ⟨r, h⟩ := hT
  exact ⟨r, h.smul c⟩
