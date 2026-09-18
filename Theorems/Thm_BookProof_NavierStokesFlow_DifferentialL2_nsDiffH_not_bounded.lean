-- Generated from ChapterNavierStokesDifferentialL2.lean — theorem BookProof.NavierStokesFlow.DifferentialL2.nsDiffH_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesDifferentialL2
open BookProof.NavierStokesFlow.DifferentialL2
variable (A : Matrix (Fin 3) (Fin 3) ℝ)



open MeasureTheory MvPolynomial
variable (A : Matrix (Fin 3) (Fin 3) ℝ)
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
variable (A : Matrix (Fin 3) (Fin 3) ℝ)
open BookProof.NavierStokesFlow
variable (A : Matrix (Fin 3) (Fin 3) ℝ)
open BookProof.NavierStokesFlow.LpNat BookProof.NavierStokesFlow.IkebeKato
variable (A : Matrix (Fin 3) (Fin 3) ℝ)
open BookProof.FarisLavine
variable (A : Matrix (Fin 3) (Fin 3) ℝ)
open BookProof.NavierStokesFlow.ThreeComponent BookProof.NavierStokesFlow.CanonicalVector
variable (A : Matrix (Fin 3) (Fin 3) ℝ)
open BookProof.NavierStokesFlow.LagrangianEsa
variable (A : Matrix (Fin 3) (Fin 3) ℝ)

noncomputable section

theorem BookProof.NavierStokesFlow.DifferentialL2.nsDiffH_not_bounded (hA : A 0 0 ≠ 0) (K : ℝ) :
    ∃ f : polyGaussCore (d := 3), ‖(f : L2d 3)‖ = 1
      ∧ K < ‖((nsDiffH A c f : polyGaussCore (d := 3)) : L2d 3)‖ := by sorry
