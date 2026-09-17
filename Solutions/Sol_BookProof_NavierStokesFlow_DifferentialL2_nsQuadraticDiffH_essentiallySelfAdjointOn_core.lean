-- Generated from ChapterNavierStokesDifferentialL2.lean — solution of BookProof.NavierStokesFlow.DifferentialL2.nsQuadraticDiffH_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_nsDiffH_essentiallySelfAdjointOn_core
open BookProof.NavierStokesFlow.DifferentialL2




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LpNat BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.ThreeComponent BookProof.NavierStokesFlow.CanonicalVector
open BookProof.NavierStokesFlow.LagrangianEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution
    (nu : ℝ) (grad : Matrix (Fin 3) (Fin 3) ℝ) (lap : Fin 3 → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 3))
      ((polyGaussCore (d := 3)).subtype.comp (nsQuadraticDiffH nu grad lap)) := nsDiffH_essentiallySelfAdjointOn_core grad _
