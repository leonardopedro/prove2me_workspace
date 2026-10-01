-- Generated from ChapterNavierStokesCanonicalVector.lean — theorem BookProof.NavierStokesFlow.CanonicalVector.rotHop_hFun
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)


open scoped ENNReal



open LpNat FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

theorem BookProof.NavierStokesFlow.CanonicalVector.rotHop_hFun (i k : Fin 3) (X : Vel → ℂ) (γ : Vel) :
    (rotHop A c i k).hFun X γ
      = Complex.I * (((coefRot A i k : ℝ) : ℂ)
        * (cFun i (aFun k X) γ - aFun i (cFun k X) γ)) := by sorry
