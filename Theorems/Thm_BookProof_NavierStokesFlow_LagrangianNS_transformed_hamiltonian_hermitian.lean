-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.LagrangianNS.transformed_hamiltonian_hermitian
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.ChapterF7
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow


open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]
variable {n : ℕ} (L : LagrangianNS n)

theorem BookProof.NavierStokesFlow.LagrangianNS.transformed_hamiltonian_hermitian : (L.hFull)ᴴ = L.hFull := by sorry
