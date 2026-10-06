-- Generated from ChapterWeylSL2Group.lean — solution of BookProof.ChapterWeylSL2Group.isExpOfSl2_stdRep
import Mathlib
import Definitions.Def_ChapterWeylSL2Group
open BookProof.ChapterWeylSL2Group




open BookProof.ChapterWeylSl2

universe u

variable {V : Type u} [AddCommGroup V] [Module ℂ V]

variable {V : Type u} [AddCommGroup V] [Module ℂ V]
variable {rho : Representation ℂ (Matrix.SpecialLinearGroup (Fin 2) ℂ) V} {R : Sl2Rep V} {N : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution : IsExpOfSl2 stdRep stdSl2 2 where
  two_le :=
  where
    two_le := le_rfl
    expE t := by
      have hsum : (∑ k ∈ Finset.range 2, (t ^ k / (Nat.factorial k : ℂ)) • stdSl2.E ^ k)
          = 1 + t • stdSl2.E := by
        simp [Finset.sum_range_succ]
      have hmat : ((uPlus t : Matrix.SpecialLinearGroup (Fin 2) ℂ) :
          Matrix (Fin 2) (Fin 2) ℂ) = 1 + t • eMat := by
        ext i j
        fin_cases i <;> fin_cases j <;> simp [uPlus, eMat]
      rw [hsum]
      change Matrix.toLin' ((uPlus t : Matrix.SpecialLinearGroup (Fin 2) ℂ) :
        Matrix (Fin 2) (Fin 2) ℂ) = 1 + t • Matrix.toLin' eMat
      rw [hmat, map_add, map_smul, Matrix.toLin'_one]
      rfl
    expF t := by
      have hsum : (∑ k ∈ Finset.range 2, (t ^ k / (Nat.factorial k : ℂ)) • stdSl2.F ^ k)
          = 1 + t • stdSl2.F := by
        simp [Finset.sum_range_succ]
      have hmat : ((uMinus t : Matrix.SpecialLinearGroup (Fin 2) ℂ) :
          Matrix (Fin 2) (Fin 2) ℂ) = 1 + t • fMat := by
        ext i j
        fin_cases i <;> fin_cases j <;> simp [uMinus, fMat]
      rw [hsum]
      change Matrix.toLin' ((uMinus t : Matrix.SpecialLinearGroup (Fin 2) ℂ) :
        Matrix (Fin 2) (Fin 2) ℂ) = 1 + t • Matrix.toLin' fMat
      rw [hmat, map_add, map_smul, Matrix.toLin'_one]
      rfl
