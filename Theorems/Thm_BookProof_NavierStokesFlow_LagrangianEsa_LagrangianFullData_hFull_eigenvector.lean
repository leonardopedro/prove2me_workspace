-- Generated from ChapterNavierStokesLagrangianEsa.lean — theorem BookProof.NavierStokesFlow.LagrangianEsa.LagrangianFullData.hFull_eigenvector
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianEsa
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.BRSTNilpotent
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianEsa

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)




open FullEsa

theorem BookProof.NavierStokesFlow.LagrangianEsa.LagrangianFullData.hFull_eigenvector {v : L.D} {p q dr : Fin 3 → ℝ} {c : ℝ}
    (hP : ∀ i, L.P i v = ((p i : ℝ) : ℂ) • v) (hQ : ∀ i, L.Q i v = ((q i : ℝ) : ℂ) • v)
    (hD : ∀ i, L.drive i v = ((dr i : ℝ) : ℂ) • v)
    (hC : L.constraintOp v = ((c : ℝ) : ℂ) • v) :
    L.hFull v = ((L.eigenvalue p q dr c : ℝ) : ℂ) • v := by sorry
