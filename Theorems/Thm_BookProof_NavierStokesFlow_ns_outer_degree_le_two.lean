-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.ns_outer_degree_le_two
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow


open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

variable {n : ℕ}

theorem BookProof.NavierStokesFlow.ns_outer_degree_le_two {m : ℕ} (A : Fin m → Matrix (Fin n) (Fin n) ℂ)
    (h : Matrix (Fin m) (Fin m) ℂ) :
    nsSecondQuant A h
        = ∑ a : Fin m × Fin m,
            h a.1 a.2 • (([Sum.inl a.1, Sum.inr a.2].map (nsOuterGen A)).prod)
      ∧ ∀ a : Fin m × Fin m, ([Sum.inl a.1, Sum.inr a.2] : List (Fin m ⊕ Fin m)).length ≤ 2 := by sorry
