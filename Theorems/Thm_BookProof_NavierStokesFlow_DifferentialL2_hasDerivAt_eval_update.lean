-- Generated from ChapterNavierStokesDifferentialL2.lean — theorem BookProof.NavierStokesFlow.DifferentialL2.hasDerivAt_eval_update
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

_sq_sec, hS]
  ring

theorem BookProof.NavierStokesFlow.DifferentialL2.hasDerivAt_eval_update (i : Fin d) (p : MvPolynomial (Fin d) ℂ) (x : Fin d → ℂ) (t : ℂ) :
    HasDerivAt (fun s : ℂ => MvPolynomial.eval (Function.update x i s) p)
      (MvPolynomial.eval (Function.update x := by sorry
