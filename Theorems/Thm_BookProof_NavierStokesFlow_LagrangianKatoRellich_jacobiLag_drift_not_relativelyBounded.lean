-- Generated from ChapterNavierStokesLagrangianKatoRellich.lean — theorem BookProof.NavierStokesFlow.LagrangianKatoRellich.jacobiLag_drift_not_relativelyBounded
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianKatoRellich

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable (L : LagrangianFullData F)
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


open Filter Topology



open FullEsa LagrangianEsa BookProof.FarisLavine BookProof.KatoRellich
open BookProof.EsaClosure BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin

nly nonzero term is an unbounded first-order drift — the
positive second-order part is the **zero** operator. -/
theorem BookProof.NavierStokesFlow.LagrangianKatoRellich.jacobiLag_drift_not_relativelyBounded : secondOrder jacobiLagData = 0 := by
  have hP : ∀ i : Fin 3, jacobiLagData.P i = 0 := fun _ => rfl
  have hQ : ∀ i : Fin 3, jacobiLagData.Q i = 0 := fun _ => rfl
  simp [secondOrder, LagrangianFullData.kinetic, LagrangianFullData.viscous, hP, hQ]

/-- **Why the counterexample does not contradict this module.**  In the sharpness
example there is no relative bound of the drift against the parcel momenta: if
there were one, the Kato–Rellich theorem above would apply — the second-order
part is `0`, which is essentially self-adjoint, and the constraint vanishes — and
would make the transformed Hamiltonian essentia := by sorry
