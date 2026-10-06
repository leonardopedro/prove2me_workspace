-- Generated from ChapterHermiteBandCalculusHigher.lean — theorem BookProof.HermiteBandHigher.mulOp_sum
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculusHigher
import Definitions.Def_ChapterF7
open BookProof.ChapterF7
open BookProof.HermiteBandHigher

variable {d : ℕ}



noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.YangMillsHermite
open BookProof.NavierStokesFlow.DifferentialL2


theorem BookProof.HermiteBandHigher.mulOp_sum {ι : Type*} (s : Finset ι) (F : ι → MvPolynomial (Fin d) ℂ) :
    mulOp (∑ i ∈ s, F i) = ∑ i ∈ s, mulOp (F i) := by sorry
