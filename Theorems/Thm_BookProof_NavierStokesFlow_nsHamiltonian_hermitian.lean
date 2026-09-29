-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.nsHamiltonian_hermitian
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow












open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct




variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]















variable {n : ℕ} (L : LagrangianNS n)

















variable {n : ℕ} (d : NSTruncation n)

theorem BookProof.NavierStokesFlow.nsHamiltonian_hermitian : (nsHamiltonian d)ᴴ = nsHamiltonian d := by sorry
