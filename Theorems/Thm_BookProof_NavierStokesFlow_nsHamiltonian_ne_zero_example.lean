-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.nsHamiltonian_ne_zero_example
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow.CanonicalVector
open BookProof.NavierStokesFlow


open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]
variable {n : ℕ} (L : LagrangianNS n)
variable {n : ℕ} (d : NSTruncation n)

theorem BookProof.NavierStokesFlow.nsHamiltonian_ne_zero_example :
    nsHamiltonian (nsTruncationOfDiagonal (n := 1) (fun _ _ => 1) (fun _ => 1)
      (fun _ => Matrix.conjTranspose_one) 0) ≠ 0 := by sorry
