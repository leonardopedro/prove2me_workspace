-- Generated from ChapterNsFourierElimination.lean — theorem BookProof.NsFullEuler.nsElimSubst_advect
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Mathlib
import Definitions.Def_ChapterNsFourierElimination
import Definitions.Def_ChapterNavierStokesFullEulerianFock
open BookProof.NsFullEuler

variable {n : ℕ}



open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL

noncomputable section


theorem BookProof.NsFullEuler.nsElimSubst_advect (k : Fin 3 → ℝ) (n : ℕ) (p : Fin n) (i : Fin 3) :
    nsElimHom k n (∑ j : Fin 3, X (ycoord p (uIdx j)) * X (ycoord p (dIdx i j)))
      = C Complex.I * liftParcel p (fourierAdvect k i) := by sorry
