-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.LagrangianNS.sum_sq_posSemidef
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianNS












open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct




variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]















variable {n : ℕ} (L : LagrangianNS n)

theorem BookProof.NavierStokesFlow.LagrangianNS.sum_sq_posSemidef {m : ℕ} {R : Fin 3 → Matrix (Fin m) (Fin m) ℂ}
    (hR : ∀ i, (R i)ᴴ = R i) : (∑ i, R i * R i).PosSemidef := by sorry
