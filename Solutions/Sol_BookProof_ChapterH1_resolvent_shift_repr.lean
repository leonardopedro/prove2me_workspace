-- Generated from ChapterH1.lean — solution of BookProof.ChapterH1.resolvent_shift_repr
import Mathlib
import Definitions.Def_ChapterH1
import Theorems.Thm_BookProof_ChapterH1_resolvent_shift_mul
open BookProof.ChapterH1



open scoped BigOperators
open intervalIntegral


noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {A : Type*} [Ring A] [Algebra ℂ A]

set_option maxHeartbeats 1000000 in
unction
`X_j = (1 + h(m−j)·X_m)⁻¹ · X_m` of `X_m` (Hashimoto §4, "Since `X_j` is
represented as …").  This is the load-bearing algebraic identity from which the
rational-Krylov subspace equality `Q_m({X_j}, v) = {r(X_m) v | r ∈ R_SIRK}`
(eq. 11) follows by induction: each `X_j` raises the numerator degree by ≤ 1 and
multiplies the denominator by one more `(1 + h·i·z)` := 
