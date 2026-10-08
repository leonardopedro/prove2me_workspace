-- Generated from ChapterBookBrstYangMills.lean — theorem BookProof.BookBrstYangMills.gaussGenPoly_eq
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
import Definitions.Def_ChapterNavierStokesDifferentialL2
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.BookBrstYangMills



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

theorem BookProof.BookBrstYangMills.gaussGenPoly_eq (c : Fin N) :
    gaussGenPoly G c = (-Complex.I) •
      ((∑ μ, ∑ a, ((G.D μ c a : ℝ) : ℂ) • momPoly μ a)
        - (∑ μ, ∑ a, ∑ b, ((G.f a b c : ℝ) : ℂ) • (momPoly μ a * AfieldPoly μ b))) := by sorry
