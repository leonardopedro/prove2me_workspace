-- Generated from ChapterBookBrstYangMills.lean — theorem BookProof.BookBrstYangMills.sum_smul_der_apply
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
open BookProof.BookBrstYangMills

variable {N : ℕ} (G : GaugeAlgebra N)



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

theorem BookProof.BookBrstYangMills.sum_smul_der_apply {n : ℕ} (k : Fin n → ℂ)
    (D : Fin n → Derivation ℂ (FieldPoly N) (FieldPoly N)) (p : FieldPoly N) :
    (∑ h, k h • D h) p = ∑ h, k h • (D h) p := by sorry
