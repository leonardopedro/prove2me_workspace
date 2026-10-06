-- Generated from ChapterHermiteBandCalculusHigher.lean — theorem BookProof.HermiteBandHigher.isBandDeg1_annPoly
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculusHigher
import Definitions.Def_ChapterHermiteProductBasis
open BookProof.HermiteProductBasis
open BookProof.HermiteBandHigher

variable {d : ℕ}



noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.YangMillsHermite
open BookProof.NavierStokesFlow.DifferentialL2


theorem BookProof.HermiteBandHigher.isBandDeg1_annPoly (i : Fin d) : IsBandDeg 1 (annPoly i) := by sorry
