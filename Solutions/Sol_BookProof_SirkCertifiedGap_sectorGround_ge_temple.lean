-- Generated from ChapterSirkCertifiedGap.lean — solution of BookProof.SirkCertifiedGap.sectorGround_ge_temple
import Mathlib
import Definitions.Def_ChapterSirkCertifiedGap
import Theorems.Thm_BookProof_SirkCertifiedGap_sectorRestrict_isSymmetric
import Theorems.Thm_BookProof_SirkCertifiedGap_rayleigh_sectorRestrict
import Theorems.Thm_BookProof_SirkCertifiedGap_sectorGround_eq_inf_eigenvalues
import Theorems.Thm_BookProof_RitzCertificate_temple_lower_bound
import Definitions.Def_ChapterSirkFinitePrecision
open BookProof.SirkCertifiedGap











noncomputable section


open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution {T P : E →ₗ[ℂ] E} {s : ℝ}
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
      ≤ sectorGround T P s := by

  classical
  set hSym := sectorRestrict_isSymmetric (s := s) hcomm hT with hSymdef
  have hground := sectorGround_eq_inf_eigenvalues hcomm hT hne
  have hlow : ∀ i, sectorGround T P s ≤ hSym.eigenvalues (rfl) i := by
    intro i
    rw [hground]
    exact Finset.inf'_le _ (mem_univ i)
  have hray : rayleigh (sectorRestrict T P s hcomm) y = rayleigh T (y : E) :=
    rayleigh_sectorRestrict hcomm y
  have hnorm : ‖(sectorRestrict T P s hcomm) y‖ = ‖T (y : E)‖ := by
    simp
  have := temple_lower_bound hSym (rfl) hy (lam0 := sectorGround T P s) (β := β)
    hsep hlow (by rwa [hray])
  rwa [hray, hnorm] at this
