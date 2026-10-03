-- Generated from ChapterBookBrstYangMills.lean — theorem BookProof.BookBrstYangMills.gaussGenPoly_bracket
import Definitions.Def_ChapterBRSTNilpotent
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
import Definitions.Def_ChapterA4

variable {N : ℕ} (G : GaugeAlgebra N)



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

theorem BookProof.BookBrstYangMills.gaussGenPoly_bracket (c e : Fin N) :
    gaussGenPoly G c * gaussGenPoly G e - gaussGenPoly G e * gaussGenPoly G c
      = ∑ h, (G.f c e h) • gaussGenPoly G h := by sorry
