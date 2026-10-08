-- Generated from ChapterNavierStokesCanonicalVector.lean — theorem BookProof.NavierStokesFlow.CanonicalVector.symProdFun_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Definitions.Def_ChapterNavierStokesThreeComponent
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

theorem BookProof.NavierStokesFlow.CanonicalVector.symProdFun_eq (i k : Fin 3) (X : Vel → ℂ) (γ : Vel) :
    symProdFun i k X γ
      = (Complex.I / 4) * (cFun i (cFun k X) γ + cFun i (aFun k X) γ
          - aFun i (cFun k X) γ - aFun i (aFun k X) γ
          + cFun k (cFun i X) γ - cFun k (aFun i X) γ
          + aFun k (cFun i X) γ - aFun k (aFun i X) γ) := by sorry
