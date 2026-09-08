-- Generated from ChapterSirkCertifiedGap.lean — theorem BookProof.SirkCertifiedGap.sectorGround_ge_temple
import Mathlib
import Definitions.Def_ChapterSirkCertifiedGap
open BookProof.SirkCertifiedGap










noncomputable section


open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

theorem BookProof.SirkCertifiedGap.sectorGround_ge_temple {T P : E →ₗ[ℂ] E} {s : ℝ}
    (hcomm : ∀ x, T (P x) = P (T x)) (hT : T.IsSymmetric)
    {y : paritySector P s} (hy : ‖y‖ = 1)
    (hne : (univ : Finset (Fin (Module.finrank ℂ (paritySector P s)))).Nonempty)
    {β : ℝ}
    (hsep : ∀ i, (sectorRestrict_isSymmetric (s := s) hcomm hT).eigenvalues (rfl) i
        = sectorGround T P s
      ∨ β ≤ (sectorRestrict_isSymmetric (s := s) hcomm hT).eigenvalues (rfl) i)
    (hβ : rayleigh T (y : E) < β) :
    rayleigh T (y : E)
        - (‖T (y : E)‖ ^ 2 - rayleigh T (y : E) ^ 2) / (β - rayleigh T (y : E))
      ≤ sectorGround T P s := by sorry
