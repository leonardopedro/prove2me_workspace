-- Generated from ChapterSirkCertifiedGap.lean — theorem BookProof.SirkCertifiedGap.le_sectorGround
import Definitions.Def_ChapterSirkFinitePrecision
import Mathlib
import Definitions.Def_ChapterSirkCertifiedGap
import Definitions.Def_ChapterRitzCertificate
open BookProof.RitzCertificate
open BookProof.SirkCertifiedGap


noncomputable section


open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]


theorem BookProof.SirkCertifiedGap.le_sectorGround {T P : E →ₗ[ℂ] E} {s c : ℝ}
    (hne : (sectorRayleighSet T P s).Nonempty)
    (hlb : ∀ x : E, ‖x‖ = 1 → x ∈ paritySector P s → c ≤ rayleigh T x) :
    c ≤ sectorGround T P s := by sorry
