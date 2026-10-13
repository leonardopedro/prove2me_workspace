-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.LagrangianNS.transformed_hamiltonian_decomposition
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianNS



open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]
variable {n : ℕ} (L : LagrangianNS n)

set_option maxHeartbeats 1000000 in
open BookProof.ChapterF7
theorem solution :
    L.hFull = L.kinetic + L.viscous + L.drift + L.C := rfl
