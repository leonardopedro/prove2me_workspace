-- Generated from ChapterBookBrstYangMills.lean — theorem BookProof.BookBrstYangMills.I_smul_gaussGen
import Definitions.Def_ChapterBRSTNilpotent
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterYangMillsGhostSector
import Definitions.Def_ChapterA4
open BookProof.NavierStokesFlow.CanonicalVector
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.YangMillsGhost
open BookProof.BookBrstYangMills

variable {N : ℕ} (G : GaugeAlgebra N)



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

theorem BookProof.BookBrstYangMills.I_smul_gaussGen (c : Fin N) :
    Complex.I • gaussGen G c
      = (∑ μ, ∑ a, ((G.D μ c a : ℝ) : ℂ) • mom μ a)
        - (∑ μ, ∑ a, ∑ b, ((G.f a b c : ℝ) : ℂ) • (mom μ a * Afield μ b)) := by sorry
