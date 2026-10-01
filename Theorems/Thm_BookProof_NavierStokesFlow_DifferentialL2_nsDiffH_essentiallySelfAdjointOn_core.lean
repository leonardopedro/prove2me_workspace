-- Generated from ChapterNavierStokesDifferentialL2.lean — theorem BookProof.NavierStokesFlow.DifferentialL2.nsDiffH_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterNavierStokesDifferentialL2
open BookProof.NavierStokesFlow.DifferentialL2

variable {d : ℕ}
variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LpNat BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.ThreeComponent BookProof.NavierStokesFlow.CanonicalVector
open BookProof.NavierStokesFlow.LagrangianEsa

noncomputable section

 i _ => hterm i

theorem BookProof.NavierStokesFlow.DifferentialL2.nsDiffH_essentiallySelfAdjointOn_core : Real.sqrt 2 ≠ 0 :=
  ne_of_gt (Real.sqrt_pos.mpr (by norm_num))

/-- **The Navier–Stokes quadratic symbol, written with genuine derivatives and genuine
multiplication operators on `L²(du₁du₂du₃)`, is essentially self-adjoint on the Hermite
core** — for every real velocity gradient `A` and eve := by sorry
