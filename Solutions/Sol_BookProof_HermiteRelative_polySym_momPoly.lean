-- Generated from ChapterHermiteRelativeBound.lean — solution of BookProof.HermiteRelative.polySym_momPoly
import Mathlib
import Definitions.Def_ChapterHermiteRelativeBound
import Theorems.Thm_BookProof_HermiteRelative_momPoly_eq_ymMomOp
import Theorems.Thm_BookProof_YangMillsHermite_momOp_polySym
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterLeafGaps
open BookProof.HermiteRelative




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

open BookProof.YangMillsHermite
noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] {ι : Type*}
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) : BookProof.YangMillsHermite.PolySym (momPoly i) := by

  rw [momPoly_eq_ymMomOp]
  exact BookProof.YangMillsHermite.momOp_polySym i
