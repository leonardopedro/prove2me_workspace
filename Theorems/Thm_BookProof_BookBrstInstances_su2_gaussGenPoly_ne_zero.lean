-- Generated from ChapterBookBrstInstances.lean — theorem BookProof.BookBrstInstances.su2_gaussGenPoly_ne_zero
import Definitions.Def_ChapterBookBrstYangMills
import Definitions.Def_ChapterBookBrstGaugeFixing
import Definitions.Def_ChapterSmBrstGhost
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Mathlib
import Definitions.Def_ChapterBookBrstInstances
open BookProof.BookBrstInstances



open BookProof.BookBrstYangMills BookProof.BookBrstGaugeFixing BookProof.SmBrstGhost
open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open MvPolynomial

noncomputable section

variable {N : ℕ} (f : Fin N → Fin N → Fin N → ℝ)


theorem BookProof.BookBrstInstances.su2_gaussGenPoly_ne_zero : gaussGenPoly (su2BookAlgebra 0) 0 ≠ 0 := by sorry
