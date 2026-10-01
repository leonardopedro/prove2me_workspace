-- Generated from ChapterSirkCertifiedGap.lean — theorem BookProof.SirkCertifiedGap.sectorGround_eq_inf_eigenvalues
import Definitions.Def_ChapterSirkFinitePrecision
import Mathlib
import Definitions.Def_ChapterSirkCertifiedGap
import Definitions.Def_ChapterRitzCertificate
open BookProof.RitzCertificate
open BookProof.SirkCertifiedGap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]


noncomputable section


open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision


theorem BookProof.SirkCertifiedGap.sectorGround_eq_inf_eigenvalues {T P : E →ₗ[ℂ] E} {s : ℝ}
    (hcomm : ∀ x, T (P x) = P (T x)) (hT : T.IsSymmetric)
    (hne : (univ : Finset (Fin (Module.finrank ℂ (paritySector P s)))).Nonempty) :
    sectorGround T P s
      = univ.inf' hne fun i =>
          (sectorRestrict_isSymmetric (s := s) hcomm hT).eigenvalues (rfl) i := by sorry
