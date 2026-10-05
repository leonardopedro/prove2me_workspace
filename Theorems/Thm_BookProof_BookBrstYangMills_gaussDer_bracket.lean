-- Generated from ChapterBookBrstYangMills.lean — theorem BookProof.BookBrstYangMills.gaussDer_bracket
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
open BookProof.BookBrstYangMills

variable {N : ℕ} (G : GaugeAlgebra N)



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

theorem BookProof.BookBrstYangMills.gaussDer_bracket (c e : Fin N) :
    ⁅gaussDer G c, gaussDer G e⁆
      = ∑ h, ((G.f c e h : ℝ) : ℂ) • gaussDer G h := by sorry
