-- Generated from ChapterHermiteBandCalculusHigher.lean — theorem BookProof.HermiteBandHigher.isBandR1_momPoly
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterYangMillsHermite
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculusHigher
import Definitions.Def_ChapterNavierStokesDifferentialL2
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteBandHigher



noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.YangMillsHermite
open BookProof.NavierStokesFlow.DifferentialL2

variable {d : ℕ}


theorem BookProof.HermiteBandHigher.isBandR1_momPoly (i : Fin d) : IsBandR 1 1 (momPoly i) := by sorry
