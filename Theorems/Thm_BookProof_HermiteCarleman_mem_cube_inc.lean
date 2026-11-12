-- Generated from ChapterHermiteCarlemanEsa.lean — theorem BookProof.HermiteCarleman.mem_cube_inc
--
-- REPLACEMENT node for `BookProof.HermiteCarleman.mem_cube`, whose preamble pulls
-- in `Def_ChapterHermiteProductCore` and eight more bundles.  Consumers that
-- import that node get an empty environment on the platform (every `open`
-- fails, `Finset` included) while the same file compiles locally, so the node
-- is unusable as a dependency.  This twin carries the SAME statement with the
-- smallest preamble that elaborates it: Mathlib plus the chapter's Promoted
-- bundle, which is where `cube` lives.  See PIPELINE_PLAN §8.2.
import Mathlib
import Definitions.Def_ChapterHermiteCarlemanEsaPromoted
open BookProof.HermiteCarleman

noncomputable section

variable {d : ℕ}

theorem BookProof.HermiteCarleman.mem_cube_inc {d N : ℕ} {a : Fin d →₀ ℕ} :
    a ∈ cube d N ↔ ∀ i, a i ≤ N := by sorry
