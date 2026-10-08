-- Generated from ChapterBookBrstYangMills.lean — theorem BookProof.BookBrstYangMills.gauss_field_identity
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
open BookProof.BookBrstYangMills



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

theorem BookProof.BookBrstYangMills.gauss_field_identity (a c e g : Fin N) :
    (∑ b, G.f a b e * G.f b g c) - (∑ b, G.f a b c * G.f b g e)
      = ∑ h, G.f c e h * G.f a g h := by sorry
