-- Generated from ChapterBookBrstYangMills.lean — theorem BookProof.BookBrstYangMills.gauss_const_identity
import Definitions.Def_ChapterBRSTNilpotent
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
import Definitions.Def_ChapterA4

variable {N : ℕ} (G : GaugeAlgebra N)



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

theorem BookProof.BookBrstYangMills.gauss_const_identity (μ : Fin 4) (a c e : Fin N) :
    (∑ b, G.f a b e * (-(G.D μ c b))) - (∑ b, G.f a b c * (-(G.D μ e b)))
      = ∑ h, G.f c e h * (-(G.D μ h a)) := by sorry
