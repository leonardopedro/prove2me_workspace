-- Generated from ChapterNavierStokesLagrangianEsa.lean — theorem BookProof.NavierStokesFlow.LagrangianEsa.LagrangianFullData.hasZeroDeficiencyOn_of_commonEigenvectors
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianEsa
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.BRSTNilpotent
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianEsa




open FullEsa

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)

theorem BookProof.NavierStokesFlow.LagrangianEsa.LagrangianFullData.hasZeroDeficiencyOn_of_commonEigenvectors {I : Type*} (e : I → L.D)
    (p q dr : Fin 3 → I → ℝ) (c : I → ℝ)
    (hP : ∀ i a, L.P i (e a) = ((p i a : ℝ) : ℂ) • e a)
    (hQ : ∀ i a, L.Q i (e a) = ((q i a : ℝ) : ℂ) • e a)
    (hD : ∀ i a, L.drive i (e a) = ((dr i a : ℝ) : ℂ) • e a)
    (hC : ∀ a, L.constraintOp (e a) = ((c a : ℝ) : ℂ) • e a)
    (htotal : ∀ w : F, (∀ a, (inner ℂ ((e a : F)) w : ℂ) = 0) → w = 0) :
    HasZeroDeficiencyOn L.D L.hFull := by sorry
