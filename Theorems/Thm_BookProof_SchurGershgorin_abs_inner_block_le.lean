-- Generated from ChapterSchurGershgorinGap.lean — theorem BookProof.SchurGershgorin.abs_inner_block_le
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterTruncationGapLift
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsFockGapChain
import Mathlib
import Definitions.Def_ChapterSchurGershgorinGap
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.HermiteGalerkin
open BookProof.SchurGershgorin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


noncomputable section


open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.TruncationGapLift
open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs BookProof.YangMillsFockGapChain


theorem BookProof.SchurGershgorin.abs_inner_block_le (b : HilbertBasis ℕ ℂ F) (H : finiteModeDomain b →ₗ[ℂ] F)
    {m : ℕ} {eps : ℝ}
    (hrow : ∀ i, i < m → ∀ S : Finset ℕ, (∀ j ∈ S, m ≤ j) →
      ∑ j ∈ S, ‖entry b H i j‖ ≤ eps)
    (hcol : ∀ j, m ≤ j → ∀ S : Finset ℕ, (∀ i ∈ S, i < m) →
      ∑ i ∈ S, ‖entry b H i j‖ ≤ eps)
    (x w : finiteModeDomain b) (hx : (x : F) ∈ galerkinSpan b m)
    (hw : (w : F) ∈ tailSpan b m) :
    ‖(inner ℂ (x : F) (H w) : ℂ)‖ ≤ eps * ‖(x : F)‖ * ‖(w : F)‖ := by sorry
