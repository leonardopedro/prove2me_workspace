-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.cFun_smul
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin 3) (a : ℂ) (X : Vel → ℂ) :
    cFun i (a • X) = a • cFun i X := by

  funext β; simp [cFun]; ring
