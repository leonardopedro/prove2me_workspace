-- Generated from ChapterWeylSL2Group.lean — solution of BookProof.ChapterWeylSL2Group.rho_mem_of_unipotent_inv
import Mathlib
import Definitions.Def_ChapterWeylSL2Group
import Theorems.Thm_BookProof_ChapterWeylSL2Group_exists_factorization
open BookProof.ChapterWeylSL2Group




open BookProof.ChapterWeylSl2

universe u

variable {V : Type u} [AddCommGroup V] [Module ℂ V]

variable {V : Type u} [AddCommGroup V] [Module ℂ V]
variable {rho : Representation ℂ (Matrix.SpecialLinearGroup (Fin 2) ℂ) V} {R : Sl2Rep V} {N : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {W : Submodule ℂ V}
    (hplus : ∀ (t : ℂ), ∀ v ∈ W, rho (uPlus t) v ∈ W)
    (hminus : ∀ (t : ℂ), ∀ v ∈ W, rho (uMinus t) v ∈ W)
    (g : Matrix.SpecialLinearGroup (Fin 2) ℂ) : ∀ v ∈ W, rho g v ∈ W := by

  obtain ⟨x, y, z, w, hg⟩ := exists_factorization g
  intro v hv
  have happ : rho g v = rho (uPlus x) (rho (uMinus y) (rho (uPlus z) (rho (uMinus w) v))) := by
    rw [hg]
    simp [map_mul, Module.End.mul_apply]
  rw [happ]
  exact hplus _ _ (hminus _ _ (hplus _ _ (hminus _ _ hv)))
