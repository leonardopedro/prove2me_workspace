-- Generated from ChapterHermiteBandCalculusHigher.lean — theorem BookProof.HermiteBandHigher.isBandR_zero_op
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculusHigher
import Definitions.Def_ChapterHermiteBandCalculus
open BookProof.HermiteBand
open BookProof.HermiteBandHigher



noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.YangMillsHermite
open BookProof.NavierStokesFlow.DifferentialL2

variable {d : ℕ}


theorem BookProof.HermiteBandHigher.isBandR_zero_op (r m : ℕ) :
    IsBandR r m (0 : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ) := by sorry
