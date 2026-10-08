-- Generated from ChapterNsFourierElimination.lean — theorem BookProof.NsFullEuler.nsElimHom_C
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



open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL

noncomputable section

variable {n : ℕ}


theorem BookProof.NsFullEuler.nsElimHom_C (k : Fin 3 → ℝ) (n : ℕ) (c : ℂ) :
    nsElimHom k n (C c : MvPolynomial (Fin (n * 21)) ℂ)
      = (C c : MvPolynomial (Fin (n * 6)) ℂ) := by sorry
