-- Generated from ChapterHermiteBandCalculusHigher.lean — solution of BookProof.HermiteBandHigher.isBandR_zero_op
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculusHigher
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHermiteBandCalculus
open BookProof.HermiteBandHigher




noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.YangMillsHermite
open BookProof.NavierStokesFlow.DifferentialL2

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (r m : ℕ) :
    IsBandR r m (0 : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ) := by

  refine ⟨0, 0, le_refl 0, fun α => ⟨0, ?_, ?_, ?_, ?_⟩⟩ <;> simp [hcomb]
