-- Generated from ChapterYangMillsBandBounds.lean — solution of BookProof.YangMillsBandBounds.ymHermOp_eq
import Mathlib
import Definitions.Def_ChapterYangMillsBandBounds
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFarisLavine













noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite
open BookProof.YangMillsFriedrichs
open BookProof.NavierStokesFlow.DifferentialL2 BookProof.HermiteRelative

set_option maxHeartbeats 1000000 in
set_option maxHeartbeats 4000000 in
-- the `L²` coercions of the Gauss–polynomial core and the `24` Weyl-ordered squares of the
-- Yang–Mills Hamiltonian make the defeq checks of this identification expensive
theorem solution (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    ymHermOp e fabc = (coreRepHerm e).op (ymPoly fabc) := by

  have h1 : (∑ m : Fin 24, (piOps (coreRepHerm e) m).comp (piOps (coreRepHerm e) m))
      = ∑ m : Fin 24, (coreRepHerm e).op
          ((YangMillsHermite.momOp (ymMomIdx m)).comp (YangMillsHermite.momOp (ymMomIdx m))) :=
    Finset.sum_congr rfl fun m _ => by rw [coreRep_op_comp]; rfl
  have h2 : (∑ m : Fin 24, (magOps (coreRepHerm e) fabc m).comp (magOps (coreRepHerm e) fabc m))
      = ∑ m : Fin 24, (coreRepHerm e).op
          ((mulOp (magPoly fabc (decodeSpace m) (decodeColor m))).comp
            (mulOp (magPoly fabc (decodeSpace m) (decodeColor m)))) :=
    Finset.sum_congr rfl fun m _ => by rw [coreRep_op_comp]; rfl
  rw [ymHermOp, weylOpDom, ymPoly, coreRep_op_smul, coreRep_op_add,
    coreRep_op_sum, coreRep_op_sum, h1, h2]
