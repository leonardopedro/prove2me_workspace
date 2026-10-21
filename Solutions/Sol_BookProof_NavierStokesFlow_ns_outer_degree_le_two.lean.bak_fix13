-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.ns_outer_degree_le_two
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]
variable {n : ℕ} (L : LagrangianNS n)
variable {n : ℕ} (d : NSTruncation n)
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution {m : ℕ} (A : Fin m → Matrix (Fin n) (Fin n) ℂ)
    (h : Matrix (Fin m) (Fin m) ℂ) :
    nsSecondQuant A h
        = ∑ a : Fin m × Fin m,
            h a.1 a.2 • (([Sum.inl a.1, Sum.inr a.2].map (nsOuterGen A)).prod)
      ∧ ∀ a : Fin m × Fin m, ([Sum.inl a.1, Sum.inr a.2] : List (Fin m ⊕ Fin m)).length ≤ 2 := by

  refine ⟨?_, fun a => by simp⟩
  simp [nsSecondQuant, nsOuterGen, Fintype.sum_prod_type]
