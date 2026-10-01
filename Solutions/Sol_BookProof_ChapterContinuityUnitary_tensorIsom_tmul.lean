-- Generated from ChapterContinuityUnitary.lean — solution of BookProof.ChapterContinuityUnitary.tensorIsom_tmul
import Mathlib
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary



open scoped BigOperators Matrix TensorProduct


variable {N : ℕ} [NeZero N]

set_option maxHeartbeats 1000000 in
x level:**
`L²(X) ⊗ L²(Z) ≅ L²(X × Z)`.  This is what lets the dynamics-based generator be
an ordinary Hermitian matrix on the *scalar* space `L²(X × Z)`, with no
Bochner-space machinery. -/
noncomputable def tensorIsom (X Z : Type*) [Fintype Z] [DecidableEq Z] :
    ((X → ℂ) ⊗[ℂ] (Z → ℂ)) ≃ₗ[ℂ] (X × Z → ℂ) :=
  (TensorProduct.piScalarRight ℂ ℂ (X → ℂ) Z).trans (swapCurry X Z)

theorem solution (X Z : Type*) [Fintype Z] [DecidableEq Z]
    (f : X → ℂ) (g : Z → ℂ) :
    tensorIsom X Z (f ⊗ₜ g) = fun p => f p.1 * g p.2 := by
  funext p
  simp [ten :=
  sorIsom, swapCurry, mul_comm]
  
  /-- A product initial state `Ψ₀(x, z) = f(x) e₀(z)`, in the `L²(X × Z)` picture. -/
  noncomputable def productState (X : Type*) {Z : Type*} [Fintype Z] [Decidabl
