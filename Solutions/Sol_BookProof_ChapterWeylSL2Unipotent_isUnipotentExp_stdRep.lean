-- Generated from ChapterWeylSL2Unipotent.lean — solution of BookProof.ChapterWeylSL2Unipotent.isUnipotentExp_stdRep
import Mathlib
import Definitions.Def_ChapterWeylSL2Unipotent
import Theorems.Thm_BookProof_ChapterWeylSL2Group_isExpOfSl2_stdRep
open BookProof.ChapterWeylSL2Unipotent




open BookProof.ChapterWeylSl2 BookProof.ChapterWeylSL2Group
open Polynomial

universe u

variable {M : Type*} [AddCommGroup M] [Module ℂ M]
variable {V : Type u} [AddCommGroup V] [Module ℂ V]
variable {rho : Representation ℂ (Matrix.SpecialLinearGroup (Fin 2) ℂ) V}
  {E F : Module.End ℂ V} {n : ℕ}
variable (hU : ∀ t : ℂ, rho (uPlus t) = expSum E n t)
  (hL : ∀ t : ℂ, rho (uMinus t) = expSum F n t)
variable {N : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution :
    IsUnipotentExp stdRep (Matrix.toLin' eMat) (Matrix.toLin' fMat) 2 where
  two_le :=
  where
    two_le := le_rfl
    nilpotent_E := by
      have hm : eMat * eMat = 0 := by
        ext i j
        fin_cases i <;> fin_cases j <;> simp [eMat]
      rw [pow_two, Module.End.mul_eq_comp, ← Matrix.toLin'_mul, hm, map_zero]
    nilpotent_F := by
      have hm : fMat * fMat = 0 := by
        ext i j
        fin_cases i <;> fin_cases j <;> simp [fMat]
      rw [pow_two, Module.End.mul_eq_comp, ← Matrix.toLin'_mul, hm, map_zero]
    expE t := isExpOfSl2_stdRep.expE t
    expF t := isExpOfSl2_stdRep.expF t
