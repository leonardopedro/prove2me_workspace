-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.fourierMomentum_add
import Mathlib
import Definitions.Def_ChapterNsFourierElimination
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterNavierStokesFullEulerianFock
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (k k' : Fin 3 → ℝ) :
    fourierMomentum (k + k') = fourierMomentum k + fourierMomentum k' := by

  rw [fourierMomentum, fourierMomentum, fourierMomentum, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Pi.add_apply, Complex.ofReal_add, map_add]
  ring
