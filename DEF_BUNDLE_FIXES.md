# Def Bundle Fixes - 2026-09-18

## Completed Fixes

### 1. Published ChapterWallEsaBddBelow
- **Status**: PUBLISHED
- **Fix**: Removed invalid `open BookProof.KatoRellich`
- **Impact**: Unblocked ChapterScalaronFiberFL (was waiting on this)

### 2. Published ChapterQuantumGravity3DGauge  
- **Status**: PUBLISHED
- **Action**: Used generator (`wave_generate.py --defs-only`) then API submit
- **Impact**: Now available for ChapterQgOuterFockEsa import

### 3. Fixed ChapterQgOuterFockEsa (partial)
- **Status**: SUBMITTED, PENDING COMPILATION (attempt 4/5)
- **Fixes Applied**:
  - Removed unused `open BookProof.QuantumGravity3DGauge` (will be declared once published)
  - Added missing import for `ChapterFullQuadraticEsa`
  - Changed import from `ChapterQg3DGaugeEsa` to `ChapterQuantumGravity3DGauge`
  - Removed unused opens: `BookProof.NavierStokesFlow.DifferentialL2`, `BookProof.HermiteRelative`, `BookProof.FullQuadratic`, `BookProof.Qg3DGaugeEsa`, `BookProof.StoneBridge`, etc.
- **Remaining Errors**:
  - `coreOp` - undefined identifier (from source imports)
  - `qgKappa` - defined in ChapterQuantumGravity3DGauge (just published)
  - `torsionVec`, `torsionIdx1`, `torsionIdx2` - undefined (from source imports)

## Defs Needing Regeneration

The following defs need to be regenerated using `wave_generate.py --defs-only` and then published:

1. **ChapterScalaronFiberFL** (5 attempts)
   - Error: unknown namespace `BookProof.QgOuterFockFlow`
   - Error: Unknown identifier `contDiff_starobinskyV`
   - Needs: Regenerate from source, then publish

2. **ChapterQg3DGaugeEsa** (1 attempt)
   - Error: unknown namespace `BookProof.QuantumGravity3DGauge`
   - Needs: Regenerate from source, then publish

3. **ChapterFiniteSectionSingleTime** (1 attempt)
   - Error: unknown import `ChapterSirkSingleTimeShift`
   - Needs: Dependency published first

4. **ChapterQgContinuumModeInstance** (1 attempt)
   - Error: unknown import `ChapterQgVielbeinModeInstance`
   - Needs: Dependency published first

5. **ChapterQgTimeStepping** (1 attempt)
   - Error: unknown import `ChapterQgTruncationResolvent`
   - Needs: Dependency published first

6. **ChapterQgTruncationResolvent** (1 attempt)
   - Error: unknown import `ChapterQgContinuumModeInstance`
   - Needs: Dependency published first

7. **ChapterQgVielbeinModeInstance** (1 attempt)
   - Error: unknown import `ChapterScalaronOuterFockFL`
   - Needs: Dependency published first

8. **ChapterQgManifoldModeInstance** (1 attempt)
   - Error: unknown import `ChapterQgTimeStepping`
   - Needs: Dependency published first

9. **ChapterSirkSingleTimeShift** (1 attempt)
   - Error: unknown import `ChapterQgTruncationResolvent`
   - Needs: Dependency published first

10. **ChapterQymTimeIndependentFlow** (1 attempt)
    - Error: unknown import `ChapterFiniteSectionSingleTime`
    - Needs: Dependency published first

11. **ChapterScalaronOuterFockFL** (1 attempt)
    - Error: unknown import `ChapterScalaronFiberFL`
    - Needs: Dependency published first

12. **ChapterYangMillsAbelianFockEsa** (1 attempt)
    - Error: unknown import `ChapterQymTimeIndependentFlow`
    - Needs: Dependency published first

13. **ChapterYangMillsBandBounds** (1 attempt)
    - Error: unknown import `ChapterYangMillsAbelianFockEsa`
    - Needs: Dependency published first

## Dependency Chain (in publish order)

```
ChapterWallEsaBddBelow (PUBLISHED)
  → ChapterScalaronFiberFL (5 attempts)
    → ChapterScalaronOuterFockFL (1 attempt)
      → ChapterQgVielbeinModeInstance (1 attempt)
        → ChapterQgContinuumModeInstance (1 attempt)
          → ChapterQgTruncationResolvent (1 attempt)
            → ChapterQgTimeStepping (1 attempt)
              → ChapterQgManifoldModeInstance (1 attempt)
            → ChapterSirkSingleTimeShift (1 attempt)
      → ...
  → ChapterQuantumGravity3DGauge (PUBLISHED)
    → ChapterQgOuterFockEsa (in progress)
  → ChapterQg3DGaugeEsa (1 attempt, needs regen)
    → ...
```

## Next Steps

1. **API unreachable** — `api.prove2.me` DNS fails from this sandbox. Direct publication impossible.
2. **Regenerate and publish** ChapterScalaronFiberFL (head of chain) — 5 attempts remaining
3. **Fix ChapterQgOuterFockEsa** identifier errors (`coreOp`, `qgKappa` unknown)
4. **Publish the chain** in dependency order once API is reachable
5. **Generate stubs** for 62 unsubmittable items using generator with `decl_graph.jsonl`
