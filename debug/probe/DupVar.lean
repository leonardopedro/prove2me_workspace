import Mathlib

noncomputable section

variable {Hs : Type*} [NormedAddCommGroup Hs] [InnerProductSpace ℂ Hs]
variable (D : Set Hs)
variable (P Q : Set Hs) (hdense : D ⊆ P) (hsym : Q = Q)
variable (D : Set Hs)
variable (P : Set Hs)

include hdense hsym in
theorem probe_dup : D ⊆ P := by sorry

#print probe_dup
